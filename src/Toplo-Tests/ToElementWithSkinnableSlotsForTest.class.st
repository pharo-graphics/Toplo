Class {
	#name : #ToElementWithSkinnableSlotsForTest,
	#superclass : #ToElement,
	#instVars : [
		'#child1 => ToSkinnableSlot',
		'#child2 => ToSkinnableSlot',
		'#skinRequestCount',
		'#skinRefreshedCount',
		'#skinStatesApplied'
	],
	#category : 'Toplo-Tests-Core-Slots'
}

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> child1 [

	^ child1
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> child1: aToElement [

	child1 := aToElement
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> child2 [

	^ child2
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> child2: aToElement [

	child2 := aToElement
]

{ #category : #skin }
ToElementWithSkinnableSlotsForTest >> flushSkinStates [

	skinStatesApplied := skinStatesApplied + 1.
	super flushSkinStates.
]

{ #category : #initialization }
ToElementWithSkinnableSlotsForTest >> initialize [ 

	super initialize.
	" count the number of #requestSkin sents"
	skinRequestCount := 0.
	" count the number of ToSkinchangedEvent dispatches (for the skin installer)"
	skinRefreshedCount := 0.
	" count the number of state engine applyOn: (only for dirty element stored in the space) "
	skinStatesApplied := 0.
	
	self when: ToSkinChangedEvent do: [ skinRefreshedCount := skinRefreshedCount + 1 ]
]

{ #category : #skin }
ToElementWithSkinnableSlotsForTest >> requestSkin [

	skinRequestCount := skinRequestCount + 1.
	super requestSkin.
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> skinRefreshedCount [

	^ skinRefreshedCount
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> skinRequestCount [

	^ skinRequestCount 
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> skinStatesApplied [

	^ skinStatesApplied
]
