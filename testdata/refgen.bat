::#!
@echo off
call scala %0 %*
goto :eof
::!#

import scala.io.Source
import java.io._
import scala.util.Random
import scala.collection.mutable.MutableList

var nbproduits = 9000000

var l , n = MutableList.empty[String]

for (line <- Source.fromFile("transactions_20150114.data").getLines()) {
	val cols = line.split("\\|")
	n += cols(1).take(8)
 	l += cols(2)
 }
var M = l.distinct.toList 
var D = n.distinct.toList
l = MutableList.empty[String] ; n = l


M.foreach { println }
println(D.head) ; println(D.last)
var C = 0.0
for ( magasin <- M ){
	for ( date <- D ){
		var filename = "reference_"+s"$magasin"+"_"+s"$date"+".data"
		println(s"${(C/(D.size*M.size))*100}")
		val pw =  new PrintWriter(new File(filename))
		for (i <- 1 to nbproduits) {
		    val r = Random.nextInt(10000)/100.0
		    pw.println(s"$i|$r")	
		  }
		pw.close
		C+=1
	}
}
