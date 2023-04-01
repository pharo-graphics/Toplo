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

{ #category : #built }
ToLinkButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToLinkButtonSkin >> builtPadding [ 

	^ BlInsets top: (self theme paddingXS / 2) left: (self theme paddingContentHorizontal) bottom: (self theme paddingXS / 2) right: (self theme paddingContentHorizontal)
]

{ #category : #built }
ToLinkButtonSkin >> labelSkinType [

	^ ToLinkLabelSkin type
]
