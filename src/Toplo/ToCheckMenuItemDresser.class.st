Class {
	#name : #ToCheckMenuItemDresser,
	#superclass : #ToCheckBoxDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckMenuItemDresser >> clickedIn: aMenuItem [

	aMenuItem canSwitchToNextState ifFalse: [ ^ self ].
	aMenuItem check: aMenuItem isChecked not

]

{ #category : #'api - install/uninstall  hook' }
ToCheckMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement whenClickedDo: [ self clickedIn: anElement ]

]
