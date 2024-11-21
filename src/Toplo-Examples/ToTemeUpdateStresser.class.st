Class {
	#name : #ToTemeUpdateStresser,
	#superclass : #Object,
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #running }
ToTemeUpdateStresser class >> run [

	<script>
	| p |
	p := [
	     | r th |
	     r := 0.
	     [
	     r := r + 1.
	     th := {
		           ToRawTheme.
		           ToRawDarkTheme } at: r \\ 2 + 1.
	     Toplo defaultThemeClass: th.
	     4000 milliSeconds asDelay wait ] repeat ] newProcess.
	p name: 'Toplo defaultThemeClass stress'.
	p resume
]
