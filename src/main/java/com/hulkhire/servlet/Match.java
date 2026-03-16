package com.hulkhire.servlet;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Match implements Serializable {

    // Match setup
    private String team1;
    private String team2;
    private int totalOvers;
    private String tossWinner;

    // Current innings tracker (1 or 2)
    private int currentInnings = 1;

    // ── INNINGS 1 ──────────────────────────────
    private int runs1       = 0;
    private int wickets1    = 0;
    private int ballsInOver1 = 0;
    private int completedOvers1 = 0;
    private List<String> currentOver1   = new ArrayList<>();
    private List<List<String>> allOvers1 = new ArrayList<>();
    private List<String> fallOfWickets1  = new ArrayList<>();

    // ── INNINGS 2 ──────────────────────────────
    private int runs2       = 0;
    private int wickets2    = 0;
    private int ballsInOver2 = 0;
    private int completedOvers2 = 0;
    private List<String> currentOver2   = new ArrayList<>();
    private List<List<String>> allOvers2 = new ArrayList<>();
    private List<String> fallOfWickets2  = new ArrayList<>();

    // Constructor
    public Match(String team1, String team2, int totalOvers, String tossWinner) {
        this.team1      = team1;
        this.team2      = team2;
        this.totalOvers = totalOvers;
        this.tossWinner = tossWinner;
    }

    // ── SWITCH TO INNINGS 2 ────────────────────
    public void startSecondInnings() {
        currentInnings = 2;
    }

    // ── ADD BALL (routes to correct innings) ───
    public void addBall(String ball) {
        if (currentInnings == 1) {
            addBallToInnings1(ball);
        } else {
            addBallToInnings2(ball);
        }
    }

    private void addBallToInnings1(String ball) {
        currentOver1.add(ball);
        switch (ball) {
            case "0": case "1": case "2":
            case "3": case "4": case "6":
                runs1 += Integer.parseInt(ball);
                ballsInOver1++;
                break;
            case "W":
                wickets1++;
                ballsInOver1++;
                fallOfWickets1.add(runs1 + "/" + wickets1);
                break;
            case "WD": case "NB":
                runs1 += 1;
                break;
        }
        if (ballsInOver1 == 6) {
            allOvers1.add(new ArrayList<>(currentOver1));
            currentOver1.clear();
            ballsInOver1 = 0;
            completedOvers1++;
        }
    }

    private void addBallToInnings2(String ball) {
        currentOver2.add(ball);
        switch (ball) {
            case "0": case "1": case "2":
            case "3": case "4": case "6":
                runs2 += Integer.parseInt(ball);
                ballsInOver2++;
                break;
            case "W":
                wickets2++;
                ballsInOver2++;
                fallOfWickets2.add(runs2 + "/" + wickets2);
                break;
            case "WD": case "NB":
                runs2 += 1;
                break;
        }
        if (ballsInOver2 == 6) {
            allOvers2.add(new ArrayList<>(currentOver2));
            currentOver2.clear();
            ballsInOver2 = 0;
            completedOvers2++;
        }
    }

    // ── INNINGS COMPLETE CHECK ─────────────────
    public boolean isInnings1Complete() {
        return completedOvers1 >= totalOvers || wickets1 >= 10;
    }

    public boolean isInnings2Complete() {
        // Innings 2 ends when:
        // 1. All overs done
        // 2. All 10 wickets fall
        // 3. Team2 has already crossed the target (won)
        return completedOvers2 >= totalOvers
            || wickets2 >= 10
            || runs2 > runs1;  // target crossed
    }

    public boolean isMatchComplete() {
        return currentInnings == 2 && isInnings2Complete();
    }

    // ── TARGET ────────────────────────────────
    public int getTarget() {
        return runs1 + 1;  // team2 needs 1 more than team1
    }

    public int getRunsNeeded() {
        return getTarget() - runs2;
    }

    public int getBallsRemaining() {
        int totalBalls = totalOvers * 6;
        int ballsUsed  = (completedOvers2 * 6) + ballsInOver2;
        return totalBalls - ballsUsed;
    }

    // ── WINNER ────────────────────────────────
    public String getWinner() {
        if (!isMatchComplete()) return null;

        if (runs2 > runs1) {
            // Team2 won by wickets remaining
            int wicketsRemaining = 10 - wickets2;
            return team2 + " won by " + wicketsRemaining + " wicket"
                   + (wicketsRemaining == 1 ? "" : "s") + "! 🏆";
        } else if (runs1 > runs2) {
            // Team1 won by runs
            int runsMargin = runs1 - runs2;
            return team1 + " won by " + runsMargin + " run"
                   + (runsMargin == 1 ? "" : "s") + "! 🏆";
        } else {
            return "Match Tied! 🤝";
        }
    }

    // ── CURRENT INNINGS GETTERS ───────────────
    public int getCurrentInnings()  { return currentInnings; }

    // Runs for current display
    public int getRuns() {
        return currentInnings == 1 ? runs1 : runs2;
    }

    public int getWickets() {
        return currentInnings == 1 ? wickets1 : wickets2;
    }

    public int getCompletedOvers() {
        return currentInnings == 1 ? completedOvers1 : completedOvers2;
    }

    public int getBallsInOver() {
        return currentInnings == 1 ? ballsInOver1 : ballsInOver2;
    }

    public List<String> getCurrentOver() {
        return currentInnings == 1 ? currentOver1 : currentOver2;
    }

    public List<List<String>> getAllOvers() {
        return currentInnings == 1 ? allOvers1 : allOvers2;
    }

    public List<String> getFallOfWickets() {
        return currentInnings == 1 ? fallOfWickets1 : fallOfWickets2;
    }

    public String getOverDisplay() {
        int co = getCompletedOvers();
        int bo = getBallsInOver();
        return co + "." + bo;
    }

    public String getRunRate() {
        int co = getCompletedOvers();
        int bo = getBallsInOver();
        double balls = (co * 6) + bo;
        if (balls == 0) return "0.00";
        double rr = (getRuns() / balls) * 6;
        return String.format("%.2f", rr);
    }

    // ── INNINGS 1 SPECIFIC GETTERS ────────────
    public int getRuns1()            { return runs1; }
    public int getWickets1()         { return wickets1; }
    public int getCompletedOvers1()  { return completedOvers1; }
    public int getBallsInOver1()     { return ballsInOver1; }
    public List<List<String>> getAllOvers1()    { return allOvers1; }
    public List<String> getFallOfWickets1()    { return fallOfWickets1; }

    // ── INNINGS 2 SPECIFIC GETTERS ────────────
    public int getRuns2()            { return runs2; }
    public int getWickets2()         { return wickets2; }
    public int getCompletedOvers2()  { return completedOvers2; }
    public int getBallsInOver2()     { return ballsInOver2; }
    public List<List<String>> getAllOvers2()    { return allOvers2; }
    public List<String> getFallOfWickets2()    { return fallOfWickets2; }

    // ── BASIC GETTERS ─────────────────────────
    public String getTeam1()        { return team1; }
    public String getTeam2()        { return team2; }
    public int getTotalOvers()      { return totalOvers; }
    public String getTossWinner()   { return tossWinner; }
}