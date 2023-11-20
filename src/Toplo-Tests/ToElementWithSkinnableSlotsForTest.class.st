Class {
	#name : 'ToElementWithSkinnableSlotsForTest',
	#superclass : 'ToElement',
	#instVars : [
		'#child1 => ToSkinnableSlot',
		'#child2 => ToSkinnableSlot',
		'#skinRequestCount',
		'#skinRefreshedCount',
		'#skinStatesApplied'
	],
	#category : 'Toplo-Tests-Core-Slots',
	#package : 'Toplo-Tests',
	#tag : 'Core-Slots'
}

{ #category : 'skin' }
ToElementWithSkinnableSlotsForTest >> applyStyles [

	skinStatesApplied := skinStatesApplied + 1.
	super applyStyles.
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> child1 [

	^ child1
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> child1: aToElement [

	child1 := aToElement
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> child2 [

	^ child2
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> child2: aToElement [

	child2 := aToElement
]

{ #category : 'initialization' }
ToElementWithSkinnableSlotsForTest >> initialize [ 

	super initialize.
	" count the number of #requestSkin sents"
	skinRequestCount := 0.
	" count the number of ToSkinchangedEvent dispatches (for the skin installer)"
	skinRefreshedCount := 0.
	" count the number of state engine applyOn: (only for dirty element stored in the space) "
	skinStatesApplied := 0.
	
	self when: ToSkinInstallStateRequest do: [ skinRefreshedCount := skinRefreshedCount + 1 ]
]

{ #category : 'skin' }
ToElementWithSkinnableSlotsForTest >> requestInstallSkin [

	skinRequestCount := skinRequestCount + 1.
	super requestInstallSkin.
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> skinInstallStateCount [

	^ skinRefreshedCount
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> skinRequestCount [

	^ skinRequestCount 
]

{ #category : 'accessing' }
ToElementWithSkinnableSlotsForTest >> skinStatesApplied [

	^ skinStatesApplied
]
