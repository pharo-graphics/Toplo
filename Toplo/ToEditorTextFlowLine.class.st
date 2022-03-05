Class {
	#name : #ToEditorTextFlowLine,
	#superclass : #Object,
	#instVars : [
		'elements',
		'maxWidth',
		'availableWidth',
		'nextLine',
		'width',
		'height',
		'pushedQueue',
		'origin',
		'baseline'
	],
	#category : #'Toplo-Editor-Layout'
}

{ #category : #adding }
ToEditorTextFlowLine >> add: anElement [
	"Try to assign a given element to this line (if possible) or create a new line.
	Return a line to which next element should be tried to added"
	<return: #BrEditorTextFlowLine>
	| currentLine |
	
	anElement constraints textFlow shouldPushLine
		ifTrue: [
			pushedQueue addLast: anElement.
			^ self ].
	
	currentLine := ((self hasSpaceFor: anElement) and: [ anElement constraints textFlow shouldBreakLineBefore not ])
		ifTrue: [ self push: anElement ]
		ifFalse: [ self nextLine push: anElement ].
		
	^ anElement constraints textFlow shouldBreakLineAfter
		ifTrue: [ currentLine nextLine ]
		ifFalse: [ currentLine ]
]

{ #category : #accessing }
ToEditorTextFlowLine >> baseline [
	^ baseline
]

{ #category : #accessing }
ToEditorTextFlowLine >> count [
	"Return how many lines there are in total"
	<return: #Number>
	
	^ 1 + (self hasNextLine
		ifTrue: [ self nextLine count ]
		ifFalse: [ 0 ])
]

{ #category : #geometry }
ToEditorTextFlowLine >> distanceTo: aPoint [
	"Compute the vertical distance from me to a given point"
	<return: #Number>
	| aClampedCoordinate |
	
	aClampedCoordinate := (aPoint y min: (self origin y + self height)) max: self origin y.
	
	^ (aPoint y - aClampedCoordinate) abs
]

{ #category : #enumerating }
ToEditorTextFlowLine >> do: aBlock [
	"Evaluate aBlock with each of my next lines as the argument"

	aBlock value: self.
	self hasNextLine
		ifTrue: [ nextLine do: aBlock ]
]

{ #category : #accessing }
ToEditorTextFlowLine >> elements [
	"Return a collection of all elements assigned to this line"
	<return: #OrderedCollection>

	^ elements
]

{ #category : #accessing }
ToEditorTextFlowLine >> elementsIn: anElement [
	"Return a collection of all elements assigned to this line"
	<return: #OrderedCollection>

	^ elements ifNil: [ elements := anElement children select: [ :eachChild | eachChild constraints textFlow assignedLine = self ] ]
]

{ #category : #geometry }
ToEditorTextFlowLine >> findClosestChildOf: anElement to: aPoint [
	<return: #BlElement>
	
	"use cached elements"
	elements
		ifNotNil: [ ^ self findClosestElementTo: aPoint in: elements ].
	
	"otherwise compute based on the assigned line"
	^ self
		findClosestElementTo: aPoint
		in: (anElement children select: [ :eachChild | eachChild constraints textFlow assignedLine = self ])
]

{ #category : #geometry }
ToEditorTextFlowLine >> findClosestElementTo: aPoint in: aCollectionOfElements [
	<return: #BlElement>
	| aClosestElement aClosestDistance |
	
	aClosestElement := aCollectionOfElements first.
	aClosestDistance := aClosestElement distanceToX: aPoint.
	
	aCollectionOfElements do: [ :eachElement | 
		| eachDistance |
		
		eachDistance := eachElement distanceToX: aPoint.
		eachDistance < aClosestDistance
			ifTrue: [
				aClosestDistance := eachDistance.
				aClosestElement := eachElement ] ].

	^ aClosestElement
]

{ #category : #testing }
ToEditorTextFlowLine >> hasNextLine [
	"Return true if there is a next line, false otherwise"
	<return: #Boolean>
	
	^ nextLine isNotNil
]

{ #category : #testing }
ToEditorTextFlowLine >> hasSpaceFor: anElement [
	"Return true if I am able to provide space for a given element.
	By convention I always allow element to take space if I am empty
	regardless of actual available space"
	<return: #Boolean>
	
	^ self isEmpty or: [
		| aChildWidth |
		
		aChildWidth := anElement measuredWidth + anElement margin width.
		
		"we can not directly return the comparison, because it is possible that available width
		is very very close but slightly less than (by a thousand of a pixel) the child's measured width."
		availableWidth >= aChildWidth
			ifTrue: [ true ]
			ifFalse: [ availableWidth closeTo: aChildWidth epsilon: 0.5 ] ]
]

{ #category : #geometry }
ToEditorTextFlowLine >> height [
	"Return my height which is equal to the height of the highest element"
	<return: #Number>

	^ height
]

{ #category : #initialization }
ToEditorTextFlowLine >> initialize [
	super initialize.
	
	maxWidth := Float infinity.
	width := 0.
	height := 0.
	origin := 0@0.
	baseline := 0.
	availableWidth := maxWidth.

	elements := OrderedCollection new.
	pushedQueue := LinkedList new.

	nextLine := nil
]

{ #category : #testing }
ToEditorTextFlowLine >> isEmpty [
	"Return true if I am an empty line without any element, false otherwise"
	<return: #Boolean>

	^ elements isEmpty
]

{ #category : #accessing }
ToEditorTextFlowLine >> maxWidth [
	"Return maximal width limit for the current line"
	<return: #Number>

	^ maxWidth
]

{ #category : #accessing }
ToEditorTextFlowLine >> maxWidth: aNumber [
	"Limit maximal width to the given number"

	maxWidth := aNumber.
	availableWidth := maxWidth - width
]

{ #category : #accessing }
ToEditorTextFlowLine >> nextLine [
	"Return or create a new next line to which we should continue adding elements"
	<return: #BrEditorTextFlowLine>

	^ nextLine ifNil: [
		nextLine := BrEditorTextFlowLine new
			maxWidth: maxWidth;
			pushedQueue: pushedQueue;
			yourself ]
]

{ #category : #accessing }
ToEditorTextFlowLine >> origin [
	<return: #Point>

	^ origin
]

{ #category : #accessing }
ToEditorTextFlowLine >> origin: aPoint [
	origin := aPoint
]

{ #category : #private }
ToEditorTextFlowLine >> push: anElement [
	"Push pushes given element to the end of element's collection
	and update my geometry properties taking new element into account "

	elements addLast: anElement.
	anElement constraints textFlow assignToLine: self.

	width := width + (anElement measuredWidth + anElement margin width).
	height := height max: (anElement measuredHeight + anElement margin height).
	availableWidth := maxWidth - width.
	
	baseline := baseline max: (anElement baselineOffset + anElement margin top)
]

{ #category : #accessing }
ToEditorTextFlowLine >> pushedQueue [
	^ pushedQueue
]

{ #category : #accessing }
ToEditorTextFlowLine >> pushedQueue: aQueue [
	pushedQueue := aQueue
]

{ #category : #initialization }
ToEditorTextFlowLine >> reset [
	elements := nil.
	pushedQueue := nil.

	nextLine ifNotNil: [ :aNextLine | aNextLine reset ]
]

{ #category : #geometry }
ToEditorTextFlowLine >> totalHeight [
	"Return a total height taking into account all next lines"
	<return: #Number>
	| aTotalHeight |
	
	aTotalHeight := self hasNextLine
		ifTrue: [ nextLine totalHeight ]
		ifFalse: [ 0 ].
	
	^ self height + aTotalHeight
]

{ #category : #geometry }
ToEditorTextFlowLine >> totalWidth [
	"Return a total width taking into account all next lines"
	<return: #Number>
	| aTotalWidth |
	
	aTotalWidth := self hasNextLine
		ifTrue: [ nextLine totalWidth ]
		ifFalse: [ 0 ].
	
	^ self width max: aTotalWidth
]

{ #category : #geometry }
ToEditorTextFlowLine >> width [
	"Return my width which is a sum of widths of all my elements"
	<return: #Number>

	^ width
]
