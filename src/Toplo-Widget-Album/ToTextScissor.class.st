Class {
	#name : #ToTextScissor,
	#superclass : #Object,
	#instVars : [
		'privateCount'
	],
	#category : 'Toplo-Widget-Album-Label'
}

{ #category : #splitting }
ToTextScissor >> cut: aText [ 

	^ Array streamContents: [ :stream | 
		  | lineIterator |
		  lineIterator := aText iterator.
		  [ lineIterator hasNext ] whileTrue: [
				self processNextWord: lineIterator in: stream] ]
]

{ #category : #initialization }
ToTextScissor >> initialize [
	super initialize.
	privateCount := 0.
]

{ #category : #'private - pieces computation' }
ToTextScissor >> itemValueType: anObject [

	"Return a type of an item within a segment.
	Note: return value should be never used explicitely, it is only needed
	for direct comparison, therefore can be any immutable object"

	<return: #Symbol>
	"^ self privateNextCount "
	^ anObject isSeparator
		  ifTrue: [ self privateNextCount ]
		  ifFalse: [ #letter ]
]

{ #category : #'private - pieces computation' }
ToTextScissor >> privateNextCount [

	^ privateCount := privateCount + 1
]

{ #category : #'private - pieces computation' }
ToTextScissor >> processNextWord: aTextIterator in: aStream [

	"just split it in words based on the text separator
	such as space or some other characters abnd create a text piece for each `word`"

	aTextIterator
		nextSegment: [ :aCharacter | self itemValueType: aCharacter ]
		indicesDo: [ :aStart :anEnd | aStream nextPut: (aTextIterator text from: (aStart + 1 min: anEnd) to: anEnd) ]
]
