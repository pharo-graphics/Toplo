Class {
	#name : #ToListNodeContainerCheckboxSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> selectableSkinEvent: anEvent [

	super selectableSkinEvent: anEvent.
	anEvent elementDo: [ :e | e enabled: true ]
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> unselectableSkinEvent: anEvent [

	super unselectableSkinEvent: anEvent.
	anEvent elementDo: [ :e | e enabled: false ]
]
