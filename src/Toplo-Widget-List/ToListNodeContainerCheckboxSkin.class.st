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
