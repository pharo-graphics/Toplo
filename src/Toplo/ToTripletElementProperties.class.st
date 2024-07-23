Class {
	#name : #ToTripletElementProperties,
	#superclass : #Object,
	#instVars : [
		'startContainer',
		'middleContainer',
		'endContainer',
		'startFiller',
		'endFiller',
		'startElement',
		'middleElement',
		'endElement',
		'startFlexible',
		'endFlexible',
		'endGap',
		'startGap',
		'startAlignment',
		'endAlignment',
		'endInterspace',
		'startInterspace'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToTripletElementProperties >> endAlignment [

	^ endAlignment
]

{ #category : #accessing }
ToTripletElementProperties >> endAlignment: anObject [

	endAlignment := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> endContainer [

	^ endContainer
]

{ #category : #accessing }
ToTripletElementProperties >> endContainer: anObject [

	endContainer := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> endElement [

	^ endElement
]

{ #category : #accessing }
ToTripletElementProperties >> endElement: anObject [

	endElement := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> endFiller [

	^ endFiller
]

{ #category : #accessing }
ToTripletElementProperties >> endFiller: anObject [

	endFiller := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> endFlexible [

	^ endFlexible
]

{ #category : #accessing }
ToTripletElementProperties >> endFlexible: anObject [

	endFlexible := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> endGap [

	^ endGap
]

{ #category : #accessing }
ToTripletElementProperties >> endGap: anObject [

	endGap := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> endInterspace [

	^ endInterspace
]

{ #category : #accessing }
ToTripletElementProperties >> endInterspace: anObject [

	endInterspace := anObject
]

{ #category : #initialization }
ToTripletElementProperties >> initialize [ 

	super initialize.
	startFlexible := false.
	endFlexible := false.
	startInterspace := 0.
	endInterspace := 0
]

{ #category : #accessing }
ToTripletElementProperties >> middleContainer [

	^ middleContainer
]

{ #category : #accessing }
ToTripletElementProperties >> middleContainer: anObject [

	middleContainer := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> middleElement [

	^ middleElement
]

{ #category : #accessing }
ToTripletElementProperties >> middleElement: anObject [

	middleElement := anObject
]

{ #category : #initialization }
ToTripletElementProperties >> on: anElement [

	startGap := anElement newFiller
		            id: #'start-gap';
		            yourself.
	endGap := anElement newFiller
		          id: #'end-gap';
		          yourself.
	startFiller := anElement newFiller
		               id: #'start-filler';
		               yourself.
	endFiller := anElement newFiller
		             id: #'end-filler';
		             yourself.

	startContainer := anElement newBaseContainer
		                  id: #'start-container';
		                  yourself.
	middleContainer := anElement newMiddleContainer
		                   id: #'middle-container';
		                   yourself.
	endContainer := anElement newBaseContainer
		                id: #'end-container';
		                yourself
]

{ #category : #accessing }
ToTripletElementProperties >> startAlignment [

	^ startAlignment
]

{ #category : #accessing }
ToTripletElementProperties >> startAlignment: anObject [

	startAlignment := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTripletElementProperties >> startContainer: anObject [

	startContainer := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> startElement [

	^ startElement
]

{ #category : #accessing }
ToTripletElementProperties >> startElement: anObject [

	startElement := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> startFiller [

	^ startFiller
]

{ #category : #accessing }
ToTripletElementProperties >> startFiller: anObject [

	startFiller := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> startFlexible [

	^ startFlexible
]

{ #category : #accessing }
ToTripletElementProperties >> startFlexible: anObject [

	startFlexible := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> startGap [

	^ startGap
]

{ #category : #accessing }
ToTripletElementProperties >> startGap: anObject [

	startGap := anObject
]

{ #category : #accessing }
ToTripletElementProperties >> startInterspace [

	^ startInterspace
]

{ #category : #accessing }
ToTripletElementProperties >> startInterspace: anObject [

	startInterspace := anObject
]
