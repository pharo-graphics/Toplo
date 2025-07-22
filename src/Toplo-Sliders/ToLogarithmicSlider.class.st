Class {
	#name : #ToLogarithmicSlider,
	#superclass : #ToDesignSlider,
	#category : #'Toplo-Sliders-Core'
}

{ #category : #'api - transformations' }
ToLogarithmicSlider >> valueAtX: aPoint [

	| value minP maxP minV maxV scale position |
	minP := 0.
	maxP := self barLength.
	minV := self minValue ln.
	maxV := self maxValue ln.

	scale := maxV - minV / (maxP - minP).
	position := (aPoint - bar position) x.
	value := (position - minP * scale + minV) exp.
	value := self nearestValue: value.

	^ value asFloat rounded
]
