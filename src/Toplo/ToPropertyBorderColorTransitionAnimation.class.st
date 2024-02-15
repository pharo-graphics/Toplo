Class {
	#name : #ToPropertyBorderColorTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #visiting }
ToPropertyBorderColorTransitionAnimation >> accept: aToThemeToSourceCodeVisitor [ 
	aToThemeToSourceCodeVisitor visitPropertyBorderColorTransition: self
]

{ #category : #'instance creation' }
ToPropertyBorderColorTransitionAnimation >> newRawAnimationFor: anElement to: aStopBorder [

	| newAnim |
	newAnim := BlColorTransition new
		           from: (self property read: anElement) paint color;
		           to: aStopBorder paint color;
		           onStepDo: [ :c :e |
			           self property
				           write: (BlBorderBuilder new
						            paint: c;
						            width: aStopBorder width;
						            dashArray: aStopBorder style dashArray;
						dashOffset: aStopBorder style dashOffset;
						lineCap: aStopBorder style lineCap;lineJoin: aStopBorder style lineJoin; miterLimit: aStopBorder style miterLimit;
						            build)
				           to: e ].
	^ newAnim
]
