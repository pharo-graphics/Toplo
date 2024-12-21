Class {
	#name : #ToLabelMonoLineInnerElement,
	#superclass : #BlTextElement,
	#traits : 'TToLabelInnerElement',
	#classTraits : 'TToLabelInnerElement classTrait',
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToLabelMonoLineInnerElement >> initialize [ 

	super initialize.
	self preventMouseEvents
]

{ #category : #initialization }
ToLabelMonoLineInnerElement >> initializeMeasurement [

	"self labelMeasurement."
	self editorMeasurement
]

{ #category : #testing }
ToLabelMonoLineInnerElement >> isMonoLine [ 

	^ true
]

{ #category : #'instance creation' }
ToLabelMonoLineInnerElement >> newEditor [

	| ed |
	ed := ToTextField new.
	^ ed
]

{ #category : #'t - label inner element' }
ToLabelMonoLineInnerElement >> text [

	^ super text
]

{ #category : #'t - label inner element' }
ToLabelMonoLineInnerElement >> text: aText [

	super text: aText
]
