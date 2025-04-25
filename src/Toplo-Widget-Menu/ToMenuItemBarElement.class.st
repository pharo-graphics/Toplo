"
I'm a list whose node contents is a menu item element.
"
Class {
	#name : #ToMenuItemBarElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToMenuItemBar',
	#classTraits : 'TToMenuItemBar classTrait',
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'t - bar element' }
ToMenuItemBarElement >> defaultInnerElement [

	^ ToMenuInnerBarElement onBarElement: self
]

{ #category : #'t - item bar element - accessing' }
ToMenuItemBarElement >> defaultNodeManagerClass [

	^ ToMenuItemNodeManager
]

{ #category : #initialization }
ToMenuItemBarElement >> initialize [

	super initialize.
	
	self flag: 'no focusability until focus management is understood and working '.
	self focusability: BlFocusability none.
	
	self isWrapping: true.
	self fitContent.
	self vertical: true.
	self uniformNodeWidth: true.
	"No visible primary selection"
	self selectionOption masked: true
]

{ #category : #skin }
ToMenuItemBarElement >> newRawSkin [ 

	^ ToMenuItemBarElementSkin new
]
