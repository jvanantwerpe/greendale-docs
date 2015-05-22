
Tips & Tricks
=============

GO: Changing loglevel of glog dynamically
-----------------------------------------

You can change and view the value of the ``-v=$int`` value on the fly. This is a short example
without any checks for access and other validity of the incoming request::


	    package main

	    import (
	        "flag"
	        "fmt"
	        "github.com/bahlo/goat"
	        "github.com/golang/glog"
	        "net/http"
	        "strconv"
	    )

	    func getDebugLevel(w http.ResponseWriter, r *http.Request, p goat.Params) {
	        fl := flag.Lookup("v")
	        if fl == nil {
	            flag.Set("v", "0")
	            fl = flag.Lookup("v")
	        }
	        val := fl.Value
	        if glog.V(2) {
	            glog.Infof("Value=%s\n", val)
	        }
	        data := make(map[string]string)
	        data["level"] = fmt.Sprintf("%s", val)
	        goat.WriteJSON(w, data)
	    }

	    func setDebugLevel(w http.ResponseWriter, r *http.Request, p goat.Params) {
	        if glog.V(3) {
	            glog.Warningf("attempting to set V=%s\n", p["level"])
	        }
	        v, err := strconv.ParseInt(p["level"], 10, 16)
	        if err != nil {
	            glog.Warningf("setDebugLevel(): error parsing value of v=%s: %s", p["level"], err)
	            goat.WriteError(w, http.StatusNotAcceptable, fmt.Sprintf("error setting value: %s", err))
	            return
	        }
	        if v < 0 || v > 3 {
	            glog.Warningf("setDebugLevel(): value of v out of range: %s", p["level"])
	            goat.WriteError(w, http.StatusNotAcceptable, fmt.Sprintf("value '%s' out of range", p["level"]))
	            return
	        }
	        err = flag.Set("v", p["level"])
	        if err != nil {
	            glog.Warningf("setDebugLevel(): failed setting value of v to %s: %s", p["level"], err)
	            goat.WriteError(w, http.StatusNotAcceptable, fmt.Sprintf("error setting value: %s", err))
	            return
	        }
	        if glog.V(2) {
	            glog.Warningf("Success setting V=%s", p["level"])
	        }
	        data := make(map[string]string)
	        data["message"] = fmt.Sprintf("successfully set level to %s", p["level"])
	        data["level"] = p["level"]
	        goat.WriteJSON(w, data)
	    }
	

Get number of tests in Go
--------------------------------
User the following command::

    go test -v | awk '/^=== RUN / { r += 1 } /^--- PASS: / { p += 1 } /--- FAIL: / { f+=1 } END { printf "Success=%.2f, Fail=%.2f\n", p/r, f/r }'

