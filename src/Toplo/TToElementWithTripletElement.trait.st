Trait {
	#name : #TToElementWithTripletElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endAlignment [

	^ self tripletElement endAlignment
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endAlignment: aNumber [

	self tripletElement endAlignment: aNumber
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endContainer [

	^ self tripletElement endContainer
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endElement [

	^ self tripletElement endElement
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endElement: anElement [

	self tripletElement endElement: anElement
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endFiller [

	^ self tripletElement endFiller
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endFlexible [

	^ self tripletElement endFlexible
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> endFlexible: aBoolean [

	self tripletElement endFlexible: aBoolean
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> hasEndElement [

	^ self tripletElement endElement notNil
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> hasMiddleElement [

	^ self tripletElement middleElement notNil
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> hasStartElement [

	^ self tripletElement startElement notNil
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> isEndFlexible [

	^ self tripletElement endFlexible 
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> isExact [

	^ self constraints vertical resizer isExact and: [
		  self constraints horizontal resizer isExact ]
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> isStartFlexible [

	^ self tripletElement startFlexible 
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> middleContainer [

	^ self tripletElement middleContainer
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> middleElement [

	^ self tripletElement middleElement
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> middleElement: anElement [

	self tripletElement middleElement: anElement
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startAlignment [

	^ self tripletElement startAlignment 
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startAlignment: aNumber [

	self tripletElement startAlignment: aNumber
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startContainer [

	^ self tripletElement startContainer
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startElement [

	^ self tripletElement startElement
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startElement: anElement [

	self tripletElement startElement: anElement
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startFiller [

	^ self tripletElement startFiller
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startFlexible [

	^ self tripletElement startFlexible 
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> startFlexible: aBoolean [

	self tripletElement startFlexible: aBoolean
]

{ #category : #'t - element with triplet element' }
TToElementWithTripletElement >> tripletElement [

	^ self explicitRequirement
]
