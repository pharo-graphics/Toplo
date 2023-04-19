Class {
	#name : #ToListActionSelectionDresser,
	#superclass : #ToListSelectionDresser,
	#instVars : [
		'addAction',
		'removeAction'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListActionSelectionDresser >> addAction [

	^ addAction
]

{ #category : #accessing }
ToListActionSelectionDresser >> addAction: aValuable [

	addAction := aValuable
]

{ #category : #initialization }
ToListActionSelectionDresser >> defaultAddAction [

	^ [  :dresser :listDecoration | ]
]

{ #category : #initialization }
ToListActionSelectionDresser >> defaultRemoveAction [

	^ [ :dresser :listDecoration | ]
]

{ #category : #initialization }
ToListActionSelectionDresser >> initialize [ 

	super initialize.
	self addAction: self defaultAddAction.
	self removeAction: self defaultRemoveAction
]

{ #category : #accessing }
ToListActionSelectionDresser >> removeAction [

	^ removeAction
]

{ #category : #accessing }
ToListActionSelectionDresser >> removeAction: aValuable [

	removeAction := aValuable
]

{ #category : #'api - install/uninstall  hook' }
ToListActionSelectionDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	self addAction cull: self cull: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListActionSelectionDresser >> whenRemoved: anElement [

	self removeAction cull: self cull: anElement.
	super whenRemoved: anElement.

]
