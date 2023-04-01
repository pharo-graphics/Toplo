"
Link button: used for external links.
"
Class {
	#name : #ToLinkButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Buttons'
}

{ #category : #accessing }
ToLinkButtonSkin class >> type [

	^ #link
]

{ #category : #built }
ToLinkButtonSkin >> builtBackground [

	^ self theme colorBgContainer
]

{ #category : #built }
ToLinkButtonSkin >> builtBorder [

	^ nil
]
