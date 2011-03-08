class PlotsController < ApplicationController
  def show
    @graph = open_flash_chart_object(750,450, project_plot_path(params[:id]))
    render :layout => false
  end

  def project_plot   
    chart = OpenFlashChart.new
    project = Project.find(params[:id])
    add_title(chart, project.name)
    codes = project.analysis
    
    commits = codes.map{ |code|
      code.commit
    }
    max_commit = commits.max

    complexities = codes.map{ |code|
      code.complexity
    }
    max_complexity = complexities.max
    
    add_element_for_project(chart, codes)
    add_axis(chart, max_commit, max_complexity)
    render :text => chart.to_s
  end
  
  private
  def add_title(chart, project_name)
    title = Title.new("Project: " + project_name)
    title.set_style('{font-size: 29px; color: #771177}')
    chart.set_title(title)
  end
  
  def add_axis(chart, max_x, max_y)
    x = XAxis.new
    x.set_range(0, max_x + 10, max_x/20)
    x_legend = XLegend.new("commits per file")
    x_legend.set_style('{font-size: 24px; color: #778877}')
    chart.set_x_legend(x_legend)
    chart.set_x_axis(x)
  
    y = XAxis.new
    y.set_range(0, max_y+ 10, max_y/10)
    y_legend = YLegend.new("Complexity")
    y_legend.set_style('{font-size: 24px; color: #770077}')
    chart.set_y_legend(y_legend)
    chart.set_y_axis(y)
  end
  
  def add_element_for_project(chart, codes)
    scatter = Scatter.new('#FFD600', 10) 
    scatter.values = codes.map! { |code|
      new_scatter_point(code.commit, code.complexity, code.tip)
    }
    scatter.set_dot_style("dot")
    chart.add_element(scatter)
  end
  
  def new_scatter_point(x, y, tooltip)
    s = Star.new()
    s.set_position(x,y)
    s.size=10
    s.set_tooltip(tooltip)
    s.set_colour('#8B1D55')
    s
  end
end

module OpenFlashChart
  class DotBase < Base
    def set_position(x,y)
      @x = x
      @y = y
    end
  end
end