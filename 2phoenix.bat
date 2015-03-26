::#!
@echo off
call scala %0 %*
goto :eof
::!#

import scala.io.Source
import scala.collection.mutable.MutableList
import java.io._

def fichier(Liste:List[Int] , filename:String)
{	val pw = new PrintWriter(new File(s"$filename"+".data"))	
	for (z <- Liste) { pw.println(s"$z") } ; pw.close 	}

def top100G( T:List[Tuple4[String,Int,Int,Double]], suffix:String ) = {
	var t = T.groupBy(_._2).map( x => (x._2.map(_._1).min,x._1,x._2.map(_._2).sum,x._2.map(_._4).min)).toList
	 
	fichier( t.sortBy(_._3).map(x =>x._2).reverse.take(100) , "top_100_ventes_GLOBAL_"+s"$suffix")	
	fichier( t.sortBy(_._4).map(x =>x._2).reverse.take(100) , "top_100_ca_GLOBAL_"+s"$suffix")		
}

def top100( T:List[Tuple4[String,Int,Int,Double]], suffix:String ) : List[Tuple4[String,Int,Int,Double]] = {
	var t = T.groupBy(_._2).map( x => (x._2.map(_._1).min,x._1,x._2.map(_._2).sum,x._2.map(_._4).min)).toList
	 
	fichier(t.sortBy(_._3).map(x =>x._2).reverse.take(100) , "top_100_ventes_"+s"$suffix")	
	
	var flag = true ; var p = new File("reference_"+s"$suffix"+".data").exists
	if ( p == true ) { 
 	  	var MaxID = t.map(x => x._2).max ; val lines = io.Source.fromFile("reference_"+s"$suffix"+".data").getLines
		while( (lines.hasNext) && (flag) ) {
			var col = lines.next.split("\\|")
			val idx = t.map(x => x._2).indexOf(col(0).toInt)
			if (idx >= 0 ) {t(idx)=( t(idx)._1, t(idx)._2, t(idx)._3, t(idx)._3*col(1).toDouble )}
			if (col(0).toInt > MaxID) { flag = false }
		}
		fichier( t.sortBy(_._4).map(x =>x._2).reverse.take(100) , "top_100_ca_"+s"$suffix")		
	} 
	return t
}

var date = 0
var T,T1,T2,T3,T4,T5,T6,T7 : List[Tuple4[String,Int,Int,Double]] = Nil 
for (line <- Source.fromFile( "transactions_20150114.data" ).getLines()) {
	var cols = line.split("\\|")
	if( (cols(1).take(8).toInt == date) || (cols(1).take(8).toInt == -2015) ){ 
		T =  ( cols(2) , cols(3).toInt , cols(4).toInt , 0.0 ) :: T
	} else {
		if ( date != 0 ){
			println(date)
			 
			for (magasin <- T.map(x => x._1).distinct) {
				T1 = T1 ++ top100(T.filter(x => x._1 == magasin) , s"$magasin"+"_"+s"$date")
			}
			T7= List(T7,T6,T5,T4,T3,T2,T1).reduceLeft(_++_)
			println(T7.size)
			top100G(T7,s"$date")
		}
		date = cols(1).take(8).toInt
		T7=T6; T6=T5 ; T5=T4 ; T4=T3 ; T3=T2 ; T2=T1 ;  
	}	
  }