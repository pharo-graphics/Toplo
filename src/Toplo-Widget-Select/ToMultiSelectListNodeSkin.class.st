Class {
	#name : #ToMultiSelectListNodeSkin,
	#superclass : #ToListNodeSkin,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'event handling' }
ToMultiSelectListNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e holder selectElement withGroups ifTrue: [
			e holder isGroup
				ifTrue: [
					e padding: ((e padding withTop: e padding top + 6) withBottom:
							 e padding bottom + 3) ]
				ifFalse: [ e padding: (e padding withLeft: e padding left + 6) ] ] ]
]
