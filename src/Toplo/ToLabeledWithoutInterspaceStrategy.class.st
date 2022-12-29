Class {
	#name : #ToLabeledWithoutInterspaceStrategy,
	#superclass : #ToLabeledStrategy,
	#category : #'Toplo-Core-Labeled'
}

{ #category : #layout }
ToLabeledWithoutInterspaceStrategy >> childrenIn: aLabeled [

	^ (aLabeled isLabelFirst
		   ifTrue: [ 
			   { 
				   aLabeled label.
				   aLabeled element } ]
		   ifFalse: [ 
			   { 
				   aLabeled element.
				   aLabeled label } ]) select: #notNil
]

{ #category : #layout }
ToLabeledWithoutInterspaceStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" Nothing to do "
	^ true
]
