Class {
	#name : #ToSegmentedListElementSkin,
	#superclass : #ToItemListElementSkin,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'event handling' }
ToSegmentedListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: BlStadiumGeometry new.
			e isHorizontal ifFalse: [
				e padding: ((e padding withTop: 25) withBottom: 25) ] ]
]
