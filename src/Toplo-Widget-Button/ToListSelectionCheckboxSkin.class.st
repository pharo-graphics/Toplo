Class {
	#name : #ToListSelectionCheckboxSkin,
	#superclass : #ToIconicButtonSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToListSelectionCheckboxSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent elementDo: [ :e | e checked: false ]
]

{ #category : #'event handling' }
ToListSelectionCheckboxSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| tk inner |
			inner := BlElement new.
			tk := e isIndeterminate
				      ifTrue: [ #'checkbox-indeterminate-image' ]
				      ifFalse: [
						      e isChecked
							      ifTrue: [ #'checkbox-checked-image' ]
							      ifFalse: [ #'checkbox-unchecked-image' ] ].
			inner := e valueOfTokenNamed: tk.
			e innerImage: inner.
			e image extent: (e valueOfTokenNamed: #'checkable-icon-size').
			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'padding-XS')
					 vertical: (e valueOfTokenNamed: #'padding-content-VS')) ]
]

{ #category : #'event handling' }
ToListSelectionCheckboxSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent elementDo: [ :e | e checked: true ]
]
