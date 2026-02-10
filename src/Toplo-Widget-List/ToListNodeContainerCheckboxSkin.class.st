Class {
	#name : #ToListNodeContainerCheckboxSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			"| holder |
			holder := e nodeContainer holder.
			holder isSelectable ifFalse: [
					e icon innerImageColor: Color red.
					e valueOfTokenNamed: #'checkbox-color' ]" ]
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> selectableSkinEvent: anEvent [

	super selectableSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon visibility: BlVisibility visible ]
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> unselectableSkinEvent: anEvent [

	super unselectableSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon visibility: BlVisibility hidden ]
]
