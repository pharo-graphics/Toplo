Class {
	#name : #ToButtonMenuItemDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToButtonMenuItemDresser >> leftClicked: anElement [

	super leftClicked: anElement.
	anElement allParentMenusDo: [ :pm | pm subMenuWindow close ]
]
