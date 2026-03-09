Class {
	#name : #ToListNodeContainerCheckboxSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-List'
}

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> checkedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e removeTokenNamed: #'checkbox-color'.
			e privateChecked: false.
			e icon
				innerImage: (e valueOfTokenNamed: #'checkbox-unchecked-image');
				innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ]
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> selectableSkinEvent: anEvent [

	super selectableSkinEvent: anEvent.
	anEvent elementDo: [ :e | e enabled: true ]
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| f |
			f := anEvent focused
				     ifTrue: [
				     e valueOfTokenNamed: #'selected-focused-foreground' ]
				     ifFalse: [
				     e valueOfTokenNamed: #'selected-unfocused-foreground' ].
			e addTokenNamed: #'checkbox-color' withValue: f.
			e privateChecked: true.
			e icon
				innerImage: (e valueOfTokenNamed: #'checkbox-checked-image');
				innerImageColor: (e valueOfTokenNamed: #'checkbox-color') ]
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> uncheckedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToListNodeContainerCheckboxSkin >> unselectableSkinEvent: anEvent [

	super unselectableSkinEvent: anEvent.
	anEvent elementDo: [ :e | e enabled: false ]
]
