#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <iomanip>

using namespace std;

struct Process {
    int pid;
    int at, bt, priority;

    int ct = 0;
    int tat = 0;
    int wt = 0;
    int rt = -1;

    int remaining_bt;
};

void printTable(vector<Process> p) {
    cout << "\nPID\tAT\tBT\tCT\tTAT\tWT\tRT\n";

    for (auto x : p) {
        cout << "P" << x.pid << "\t"
             << x.at << "\t"
             << x.bt << "\t"
             << x.ct << "\t"
             << x.tat << "\t"
             << x.wt << "\t"
             << x.rt << "\n";
    }
}

void calculateTimes(vector<Process>& p) {
    for (auto &x : p) {
        x.tat = x.ct - x.at;
        x.wt = x.tat - x.bt;
    }
}

/* ================= FCFS ================= */

void FCFS(vector<Process> p) {

    sort(p.begin(), p.end(),
        [](Process a, Process b) {
            return a.at < b.at;
        });

    int time = 0;

    for (auto &x : p) {

        if (time < x.at)
            time = x.at;

        x.rt = time - x.at;

        time += x.bt;

        x.ct = time;
    }

    calculateTimes(p);

    cout << "\n===== FCFS =====\n";
    printTable(p);
}

/* ================= SJF ================= */

void SJF(vector<Process> p) {

    int n = p.size();
    vector<bool> done(n, false);

    int completed = 0;
    int time = 0;

    while (completed < n) {

        int idx = -1;
        int mn = 1e9;

        for (int i = 0; i < n; i++) {

            if (!done[i] && p[i].at <= time && p[i].bt < mn) {
                mn = p[i].bt;
                idx = i;
            }
        }

        if (idx == -1) {
            time++;
            continue;
        }

        p[idx].rt = time - p[idx].at;

        time += p[idx].bt;

        p[idx].ct = time;

        done[idx] = true;
        completed++;
    }

    calculateTimes(p);

    cout << "\n===== SJF =====\n";
    printTable(p);
}

/* ================= LJF ================= */

void LJF(vector<Process> p) {

    int n = p.size();
    vector<bool> done(n, false);

    int completed = 0;
    int time = 0;

    while (completed < n) {

        int idx = -1;
        int mx = -1;

        for (int i = 0; i < n; i++) {

            if (!done[i] && p[i].at <= time && p[i].bt > mx) {
                mx = p[i].bt;
                idx = i;
            }
        }

        if (idx == -1) {
            time++;
            continue;
        }

        p[idx].rt = time - p[idx].at;

        time += p[idx].bt;

        p[idx].ct = time;

        done[idx] = true;
        completed++;
    }

    calculateTimes(p);

    cout << "\n===== LJF =====\n";
    printTable(p);
}

/* ================= HRRN ================= */

void HRRN(vector<Process> p) {

    int n = p.size();
    vector<bool> done(n, false);

    int completed = 0;
    int time = 0;

    while (completed < n) {

        int idx = -1;
        double bestRatio = -1;

        for (int i = 0; i < n; i++) {

            if (!done[i] && p[i].at <= time) {

                double ratio =
                    (double)(time - p[i].at + p[i].bt) / p[i].bt;

                if (ratio > bestRatio) {
                    bestRatio = ratio;
                    idx = i;
                }
            }
        }

        if (idx == -1) {
            time++;
            continue;
        }

        p[idx].rt = time - p[idx].at;

        time += p[idx].bt;

        p[idx].ct = time;

        done[idx] = true;
        completed++;
    }

    calculateTimes(p);

    cout << "\n===== HRRN =====\n";
    printTable(p);
}

/* ================= SRTF ================= */

void SRTF(vector<Process> p) {

    int n = p.size();

    for (auto &x : p)
        x.remaining_bt = x.bt;

    int completed = 0;
    int time = 0;

    while (completed < n) {

        int idx = -1;
        int mn = 1e9;

        for (int i = 0; i < n; i++) {

            if (p[i].at <= time &&
                p[i].remaining_bt > 0 &&
                p[i].remaining_bt < mn) {

                mn = p[i].remaining_bt;
                idx = i;
            }
        }

        if (idx == -1) {
            time++;
            continue;
        }

        if (p[idx].rt == -1)
            p[idx].rt = time - p[idx].at;

        p[idx].remaining_bt--;
        time++;

        if (p[idx].remaining_bt == 0) {

            p[idx].ct = time;
            completed++;
        }
    }

    calculateTimes(p);

    cout << "\n===== SRTF =====\n";
    printTable(p);
}

/* ================= ROUND ROBIN ================= */

void RoundRobin(vector<Process> p, int quantum) {

    int n = p.size();

    for (auto &x : p)
        x.remaining_bt = x.bt;

    queue<int> q;
    vector<bool> visited(n, false);

    int time = 0;
    int completed = 0;

    q.push(0);
    visited[0] = true;

    while (!q.empty()) {

        int i = q.front();
        q.pop();

        if (p[i].rt == -1)
            p[i].rt = time - p[i].at;

        int exec =
            min(quantum, p[i].remaining_bt);

        p[i].remaining_bt -= exec;

        time += exec;

        for (int j = 0; j < n; j++) {

            if (!visited[j] &&
                p[j].at <= time) {

                q.push(j);
                visited[j] = true;
            }
        }

        if (p[i].remaining_bt > 0) {

            q.push(i);

        } else {

            p[i].ct = time;
            completed++;
        }
    }

    calculateTimes(p);

    cout << "\n===== ROUND ROBIN =====\n";
    printTable(p);
}

/* ================= PRIORITY ================= */

void PriorityScheduling(vector<Process> p) {

    int n = p.size();
    vector<bool> done(n, false);

    int completed = 0;
    int time = 0;

    while (completed < n) {

        int idx = -1;
        int bestPriority = 1e9;

        for (int i = 0; i < n; i++) {

            if (!done[i] &&
                p[i].at <= time &&
                p[i].priority < bestPriority) {

                bestPriority = p[i].priority;
                idx = i;
            }
        }

        if (idx == -1) {
            time++;
            continue;
        }

        p[idx].rt = time - p[idx].at;

        time += p[idx].bt;

        p[idx].ct = time;

        done[idx] = true;
        completed++;
    }

    calculateTimes(p);

    cout << "\n===== PRIORITY =====\n";
    printTable(p);
}

int main() {

    vector<Process> p = {
        {1, 0, 5, 2},
        {2, 1, 3, 1},
        {3, 2, 2, 3}
    };

    FCFS(p);
    SJF(p);
    LJF(p);
    HRRN(p);
    SRTF(p);
    RoundRobin(p, 2);
    PriorityScheduling(p);

    return 0;
}
