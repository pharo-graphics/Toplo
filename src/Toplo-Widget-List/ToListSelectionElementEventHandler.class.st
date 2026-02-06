Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

]

{ #category : #'api - accessing' }
ToListSelectionElementEventHandler >> eventsToHandle [

	^ {  }
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateNodesIn: aListElement [

	aListElement nodeContainersDo: [ :container |
		| holder |
		holder := container holder.
		holder shouldIgnore ifFalse: [
			holder initializeNodeSelections ] ].
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [
	" the selection has changed but the touched indexes is empty means 
	that a selection element remains for removed indexes"

	| target |
	target := anEvent currentTarget.

	target isAttachedToSceneGraph ifFalse: [
			self differUpdateSelectionFrom: target.
			^ self ].

	self flag: 'force update here is needed - why excatly ?. 
	check with #example_contactList select the last node and 
	then remove another node with the node remove button'.
	anEvent selectionOption
		checkRepresentationIn: target
		withSelectionModel: anEvent selectionModel
		forceUpdate: true
]
