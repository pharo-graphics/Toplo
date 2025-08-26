Class {
	#name : #ToThemeUpdateStresser,
	#superclass : #Object,
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #running }
ToThemeUpdateStresser class >> run [

	<script>
	| p |
	p := [
	     | r th rand delay |
	     rand := Random new.
	     r := 0.
	     [
	     r := r + 1.
	     th := {
		           ToRawTheme.
		           ToRawDarkTheme } at: r \\ 2 + 1.
	     Toplo defaultThemeClass: th.
	     delay := rand nextIntegerBetween: 50 and: 4000.
	     delay milliSeconds asDelay wait ] repeat ] newProcess.
	p name: 'Toplo defaultThemeClass stress'.
	p resume
]
