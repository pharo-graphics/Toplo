Class {
	#name : #ToElementWithSkinnableSlotsForTest,
	#superclass : #ToElement,
	#instVars : [
		'#child1 => ToSkinnableSlot',
		'#child2 => ToSkinnableSlot',
		'#skinStateQueueApplicationCount'
	],
	#category : #'Toplo-Tests-Core-Slots'
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

{ #category : #initialization }
ToElementWithSkinnableSlotsForTest >> initialize [

	super initialize.

	" count the number of state engine applyOn: (only for dirty element stored in the space) "
	skinStateQueueApplicationCount := 0
]

{ #category : #accessing }
ToElementWithSkinnableSlotsForTest >> skinInstalledCount [

	^ self skinManager skinInstalledCount
]

{ #category : #initialization }
ToElementWithSkinnableSlotsForTest >> skinStateQueueApplicationCount [

	^ skinStateQueueApplicationCount 
]

{ #category : #initialization }
ToElementWithSkinnableSlotsForTest >> skinStateQueueApplied [

	skinStateQueueApplicationCount := skinStateQueueApplicationCount + 1
]

{ #category : #initialization }
ToElementWithSkinnableSlotsForTest >> toploExtensionClass [ 

	^ ToElementExtensionForTest 
]
