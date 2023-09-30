Class {
	#name : #ToComboBoxHeadDresser,
	#superclass : #ToComboBoxBaseHeadDresser,
	#instVars : [
		'downShortcut',
		'headPlaceholderHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> arrowDownEvent: anEvent in: anElement [

	| wasOpened |
	wasOpened := comboBox isOpened.
	wasOpened ifFalse: [
		comboBox popupEvent: anEvent.
		comboBox listElement selectedIndexes ifNotEmpty: [ ^ self ] ].
	anEvent consumed: false.
	comboBox listElement infinite fireEvent: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> arrowUpEvent: anEvent in: anElement [

	| wasOpened |
	wasOpened :=  comboBox isOpened.
	wasOpened ifFalse: [ ^ self ].
	anEvent consumed: false.
	comboBox listElement infinite fireEvent: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> escapeEvent: anEvent in: anElement [

	comboBox close
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newArrowDownShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination arrowDown;
		                action: [ :event | self arrowDownEvent: event in: anElement ];
		                name: 'Popup';
		                yourself.
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newArrowUpShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination arrowUp;
		                action: [ :event | self arrowUpEvent: event in: anElement ];
		                name: 'Popup';
		                yourself.
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newEscapeShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination escape;
		                action: [ :event | self escapeEvent: event in: anElement ];
		                name: 'Escape';
		                yourself.
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newPlaceholder: aPlaceholder in: anElement [

	anElement placeholder: aPlaceholder.
	comboBox selectedIndex isZero ifTrue: [ anElement noDataSelected ]
]
