"
In a toplo element style is first implemented in a dedicated method.
This particular method depends on the element theme.
If ToRawTheme is the element default theme, then, #installRawStyle is the styling method.
The method #installRawStyle is runned after a skin installation.
The method #requestInstallSkin must be runned to ask for the installation of the element skin
"
Class {
	#name : #ToDemo1,
	#superclass : #BlElement,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #examples }
ToDemo1 class >> example0 [

	| dem |
	dem := ToDemo1 new.
	dem ensuredSkinManager requestInstallSkinIn: self.
	dem openInSpace
]

{ #category : #examples }
ToDemo1 class >> example1 [

	| dem |
	dem := ToDemo1 new.
	" setup the default skin ->
	ask to install it.
	then run:
	ToDemo1>>installRawStyle then 
	ToDemo1Skin>>installLookEvent:
	"
	dem defaultRawSkin: ToDemoSkin1 new.
	dem openInSpace
]

{ #category : #skin }
ToDemo1 >> installRawStyle [

	super installRawStyle.
	self background: Color red.
	self border: Color black
]
