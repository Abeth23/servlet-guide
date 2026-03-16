package com.hulkhire.servlet;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Match implements Serializable {

    private String team1;
    private String team2;
    private int totalOvers;
    private String tossWinner;

    private int runs       = 0;
    private int wickets    = 0;
    private int ballsInOver = 0;
    private int completedOvers = 0;

    private List<String> currentOver = new ArrayList<>();
    private List<List<String>> allOvers = new ArrayList<>();
    private List<String> fallOfWickets = new ArrayList<>();

    // Constructor
    public Match(String team1, String team2, int totalOvers, String tossWinner) {
        this.team1       = team1;
        this.team2       = team2;
        this.totalOvers  = totalOvers;
        this.tossWinner  = tossWinner;
    }

    // Called on every ball click
    public void addBall(String ball) {

        // Record ball in current over
        currentOver.add(ball);

        // Update runs and wickets
        switch (ball) {
            case "0": case "1": case "2":
            case "3": case "4": case "6":
                runs += Integer.parseInt(ball);
                ballsInOver++;
                break;
            case "W":
                wickets++;
                ballsInOver++;
                fallOfWickets.add(runs + "/" + wickets);
                break;
            case "WD": case "NB":
                runs += 1;  // extra run, ball does NOT count
                break;
        }

        // Check if over is complete (6 legal balls)
        if (ballsInOver == 6) {
            allOvers.add(new ArrayList<>(currentOver));
            currentOver.clear();
            ballsInOver = 0;
            completedOvers++;
        }
    }

    // Innings is over if all overs done or 10 wickets
    public boolean isInningsComplete() {
        return completedOvers >= totalOvers || wickets >= 10;
    }

    // Current over display e.g. "3.4"
    public String getOverDisplay() {
        return completedOvers + "." + ballsInOver;
    }

    // Run rate
    public String getRunRate() {
        double balls = (completedOvers * 6) + ballsInOver;
        if (balls == 0) return "0.00";
        double rr = (runs / balls) * 6;
        return String.format("%.2f", rr);
    }

    // Getters
    public String getTeam1()       { return team1; }
    public String getTeam2()       { return team2; }
    public int getTotalOvers()     { return totalOvers; }
    public String getTossWinner()  { return tossWinner; }
    public int getRuns()           { return runs; }
    public int getWickets()        { return wickets; }
    public int getCompletedOvers() { return completedOvers; }
    public int getBallsInOver()    { return ballsInOver; }
    public List<String> getCurrentOver()       { return currentOver; }
    public List<List<String>> getAllOvers()     { return allOvers; }
    public List<String> getFallOfWickets()     { return fallOfWickets; }
}