package beans;

import java.util.ArrayList;
import java.util.List;

public class PointsBean {

    {
        results = new ArrayList<PointRow>();
    }

    public PointsBean() {}

    private List<PointRow> results;

    public void addRow(PointRow resultRow) {
        results.add(resultRow);
    }

    public List<PointRow> getResults() {
        return results;
    }

    public void setResults(List<PointRow> results) {
        this.results = results;
    }
}
