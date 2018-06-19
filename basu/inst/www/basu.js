function p_test_param_builder() {
    var params = {};
    params["p1"] = parseFloat($("#p1").val()) || null;
    params["p2"] = parseFloat($("#p2").val()) || null;
    params["sig.level"] = parseFloat($("#siglevel").val()) || null;
    params["power"] = parseFloat($("#power").val()) || null;
    params["alternative"] = $("#alternative").val();
    params["n"] = Number($("#size").val()) || null;
    
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }
    
    params['h'] = EH(params['p1'], params['p2']);
    delete params['p1'];
    delete params['p2'];
    return params;
}

function t_test_param_builder() {
    var params = {};
    params["d"] = parseFloat($("#d").val()) || null;
    params["sd"] = parseFloat($("#sd").val()) || null;
    params["sig.level"] = parseFloat($("#siglevel").val()) || null;
    params["power"] = parseFloat($("#power").val()) || null;
    params["alternative"] = $("#alternative").val();
    params["n1"] = Number($("#size1").val()) || null;
    params["n2"] = Number($("#size2").val()) || null;
    
    for (var key in params) {
        if (params[key] == null) {
            delete params[key];
        }
    }
    
    return params;
}


function EH(p1, p2) {
    return 2 * Math.asin(Math.sqrt(p1)) - 2 * Math.asin(Math.sqrt(p2))
}


$(document).ready(function() {
    $("#p1p").click(function() {
        var params = p_test_param_builder();
        var req = ocpu.rpc("pwr.p.test",
                           params,
                           function(output) {
                               $("#output").text(JSON.stringify(params));
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
    
    $("#p2p").click(function() {
        var params = p_test_param_builder();
        var req = ocpu.rpc("pwr.2p.test",
                           params,
                           function(output) {
                               $("#output").text(JSON.stringify(params));
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
    
    $("#t1p").click(function() {
        var params = t_test_param_builder();
        var req = ocpu.rpc("pwr.t.test",
                           params,
                           function(output) {
                               $("#output").text(JSON.stringify(params));
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
    
    $("#t2p").click(function() {
        var params = t_test_param_builder();
        var req = ocpu.rpc("pwr.2tn.test",
                           params,
                           function(output) {
                               $("#output").text(JSON.stringify(params));
                           });
        
        req.fail(function() {
            alert("Error: " + req.responseText);
        });
    });
});
