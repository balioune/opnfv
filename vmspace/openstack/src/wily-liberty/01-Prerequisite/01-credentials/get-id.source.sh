#!/bin/bash
function get_id() {
	echo `"$@" | awk '/ id / { print $4 }'`
	}
