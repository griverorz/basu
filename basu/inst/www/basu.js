/**
 * Given a string, splits it by spaces or commas
 * 
 * @param {string} x The input string
 * @param {function} parseFun the parsing function to be used
 * @returns {array}
 */
function vectorize_input(x, parseFun) {
    if (x == "") {
        return null;
    }
    var res = x.split(/[ ,]+/).map(parseFun);
    return res;
}

/**
 * Effect size calculation for proportions
 * 
 * @param {array} p1 First proportions
 * @param {array} p2 Second proportions
 * @returns {array}
 */
function EH(p1, p2) {
    if (p1.length != p2.length) {
        alert("p1 and p2 have different lengths");
    }
    var output = []
    for (var i = 0; i < p1.length; i++) {
        output[i] = 2 * Math.asin(Math.sqrt(p1[i])) - 2 * Math.asin(Math.sqrt(p2[i]));
    }
    return output;
}


/**
 * Build a table from an Object using JQuery
 * 
 * @param {object} x The output from the R basu package as called by ocpu.rpc
 * @returns a table inserted into the dashboard identified by #basuoutput
 */
function build_table(x) {

    var hnames = {
        r : "Correlation coefficient",
        h : "Effect size",
        d : "Effect size",
        n : "Sample size",
        deff : "Design effect",
        n1 : "Sample one size",
        n2 : "Sample two size",
        "sig.level" : "Significance level",
        power : "Power",
        alternative : "Alternative hypothesis",
        method : "Method",
        note : "Notes",
        "calculated_covar": "Calculated var"
    }
        
    var table = $("#basuoutput");
    table.find('tbody').empty();

    // Array with length of object
    keys = Object.keys(x);
    var len = {}
    for (var k of keys) {
        len[k] = typeof x[k] != "object" ? 1 : Array.from(x[k]).length;
    }
    mlen = Math.max(...Object.values(len))
    
    // Separate variables in rows and columns
    to_rows = [];
    to_cols = [];
    for (var i in len) {        
        if (len[i] <= 1) {
            to_rows.push(i);
        } else {
            to_cols.push(i);
        }
    }
    ncols = to_cols.length
    to_row = to_rows.filter(e => e != "calculated_covar")
    
    // Ensure calculated variable is last
    if (to_cols.length > 1) {
        to_cols = to_cols.filter(e => e != x['calculated_covar']);
        to_cols = to_cols.concat(x['calculated_covar'])
    }

    if (to_cols.length > 0) {
        for (var i=0; i < (mlen + 1); i++) {
            var row =  $('<tr/>', { class: '' });
            row.append($('<td/>').append(''));

            for (var j=0; j < ncols; j++) {
                if (i == 0) {
                    row.append($('<td/>', { class: "headrow"} ).append(hnames[to_cols[j]]));
                } else {
                    row.append($('<td/>').append(x[to_cols[j]][i - 1]));
                }
            }                                
            table.find('tbody').append(row); 
        }
    }

    for (var key of to_rows) {
        var row =  $('<tr/>', { class: '' });
        row.append($('<td/>', { class: "headcol" }).append(hnames[key]));
        row.append($('<td/>', { colspan: mlen }).append(x[key]));
        table.find('tbody').append(row); 
    }
    
    $('#basuoutput').addClass("table table-hover table-fit");
    $("tr:even").addClass("table-active");
    $('.headrow').css('font-weight', 'bold');
    $('.headcol').css('font-weight', 'bold');
}

/**
 * Build a table from an Object using JQuery for the Cohen Table
 * 
 * @param {object} x The output from cohen.table of the pwr package as called by ocpu.rpc
 * @returns a table inserted into the dashboard identified by #basuoutput
 */
function cohen_table(x) {
    
    var hnames = {
        "test" : "Test",
        "size" : "Size",
        "effect.size" : "Effect size",
        "method" : "Method",
    }

    var table = $("#basuoutput");
    table.find('tbody').empty();
        
    for (var key in x){
        var row =  $('<tr/>', {class: '' }); 
        row.append($('<td/>').append(hnames[key]));
        row.append($('<td/>').append(x[key]));
        table.find('tbody').append(row);
    }
    $('#basuoutput').addClass("table table-hover");
    $("tr:even").addClass("table-active");    
}


/**
 * Preprocessing of the parameters for p.test in pwr
 *
 * @param None Inputs data from the HTML directly using JQuery
 * @returns {Object} The clean version of the parameters formated to be fed to R
 * through the ocpu.rpc function. Notice that if two proportions are passed, the
 * function will first calculate the effective sample size.
 */
function p_test_param_builder() {
    var params = {};
    params["p1"] = vectorize_input($("#p1").val(), parseFloat) || null;
    params["p2"] = vectorize_input($("#p2").val(), parseFloat) || null;
    params["sig.level"] = vectorize_input($("#siglevel").val(), parseFloat) || null;
    params["power"] = vectorize_input($("#power").val(), parseFloat) || null;
    params["alternative"] = $("#alternative").val();
    params["n"] = vectorize_input($("#size1").val(), parseFloat) || null;
    params["deff"] = parseFloat($("#deff").val());

    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }

    if (params["p2"] == null) {
        params['h'] = params['p1'];
    } else {
        params['h'] = EH(params['p1'], params['p2']);
    }
    
    delete params['p1'];
    delete params['p2'];
    return params;
}

/**
 * Preprocessing of the parameters for t.test in pwr
 *
 * @param None Inputs data from the HTML directly using JQuery
 * @returns {Object} The clean version of the parameters formated to be fed to R
 * through the ocpu.rpc function.
 */
function t_test_param_builder() {
    var params = {};
    params["d"] = vectorize_input($("#td").val(), parseFloat) || null;
    params["sig.level"] = vectorize_input($("#tsiglevel").val(), parseFloat) || null;
    params["power"] = vectorize_input($("#tpower").val(), parseFloat) || null;
    params["n"] = vectorize_input($("#tsize").val(), parseFloat) || null;
    params["alternative"] = $("#talternative").val();
    params["type"] = $("#ttype").val();
    params["deff"] = parseFloat($("#deff").val()); 
    
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }
    
    return params;
}


/**
 * Preprocessing of the parameters for r.test in pwr
 *
 * @param None Inputs data from the HTML directly using JQuery
 * @returns {Object} The clean version of the parameters formated to be fed to R
 * through the ocpu.rpc function. 
 */
function r_test_param_builder() {
    var params = {};
    params["r"] = vectorize_input($("#rr").val(), parseFloat) || null;
    params["sig.level"] = vectorize_input($("#rsiglevel").val(), parseFloat) || null;
    params["power"] = vectorize_input($("#rpower").val(), parseFloat) || null;
    params["n"] = vectorize_input($("#rsize").val(), parseFloat) || null;
    params["alternative"] = $("#ralternative").val();
    
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }
    
    return params;
}


$(document).ready(function() {
    
    $("#ptest").click(function() {
        var params = p_test_param_builder();
        var f = $("#pfunction").val();
        var req = ocpu.rpc(f,
                           params,                           
                           function(output) {
                               if (("n" in params) && (params["deff"] != 1)) {
                                   output["deff"] = "Design effect was ignored";
                               }

                               build_table(output);
                           });
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });

    $("#ttest").click(function() {
        var params = t_test_param_builder();
        var req = ocpu.rpc("v.pwr.t.test",
                           params,
                           function(output) {
                               if (("n" in params) && (params["deff"] != 1)) {
                                   output["deff"] = "Design effect was ignored";
                               }
                               build_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
    $("#rtest").click(function() {
        var params = r_test_param_builder();
        var req = ocpu.rpc("v.pwr.r.test",
                           params,
                           function(output) {
                               build_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
   
    $("#cohensize").click(function() {
        var req = ocpu.rpc("cohen.ES",
                           {
                               test : $("#cohentest").val(),
                               size : $("#coheneffsize").val()
                           },
                           function(output) {
                               cohen_table(output);
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });

});
