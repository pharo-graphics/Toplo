Class {
	#name : #ToListSelectionWithActionsDresser,
	#superclass : #ToListSelectionDresser,
	#instVars : [
		'addedToParentAction',
		'removedFromParentAction'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSelectionWithActionsDresser >> addedToParentAction [

	^ addedToParentAction
]

{ #category : #accessing }
ToListSelectionWithActionsDresser >> addedToParentAction: aValuable [

	addedToParentAction := aValuable
]

{ #category : #initialization }
ToListSelectionWithActionsDresser >> defaultAddedToParentAction [

	^ [  :dresser :listDecoration | ]
]

{ #category : #initialization }
ToListSelectionWithActionsDresser >> defaultRemovedFromParentAction [

	^ [ :dresser :listDecoration | ]
]

{ #category : #initialization }
ToListSelectionWithActionsDresser >> initialize [ 

	super initialize.
	self addedToParentAction: self defaultAddedToParentAction.
	self removedFromParentAction: self defaultRemovedFromParentAction
]

{ #category : #accessing }
ToListSelectionWithActionsDresser >> removedFromParentAction [

	^ removedFromParentAction
]

{ #category : #accessing }
ToListSelectionWithActionsDresser >> removedFromParentAction: aValuable [

	removedFromParentAction := aValuable
]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionWithActionsDresser >> whenAddedToParent: anElement [

	super whenAddedToParent: anElement.
	self addedToParentAction cull: self cull: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListSelectionWithActionsDresser >> whenRemovedFromParent: anElement [

	self removedFromParentAction cull: self cull: anElement.
	super whenRemovedFromParent: anElement.

]
