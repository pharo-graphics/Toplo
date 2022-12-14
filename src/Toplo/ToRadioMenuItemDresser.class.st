Class {
	#name : #ToRadioMenuItemDresser,
	#superclass : #ToRadioButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioMenuItemDresser >> clickedIn: aMenuItem [

	aMenuItem canSwitchToNextState ifFalse: [ ^ self ].
	aMenuItem check: aMenuItem isChecked not

]

{ #category : #'api - install/uninstall  hook' }
ToRadioMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement whenClickedDo: [ :event | event consumed: true. self clickedIn: anElement ]

]
