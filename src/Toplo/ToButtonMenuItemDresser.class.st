Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToPairedButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonMenuItemDresser >> leftClicked: anElement [

	super leftClicked: anElement.
	anElement allParentMenusDo: [ :pm | pm subMenuWindow close ]
]

{ #category : #'api - install/uninstall  hook' }
ToButtonMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement


]
