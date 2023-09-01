Class {
	#name : #ToSelectInnerButton,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'menuWindow'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #'t - menu window model - window opening/closing' }
ToSelectInnerButton >> close [

	^ self menuWindow close
]

{ #category : #'t - initialization dresser' }
ToSelectInnerButton >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToMenuWindowModelDresser next: (ToSelectInnerButtonDresser next: ToTripletDresser new))
]

{ #category : #'t - skinable - initialization' }
ToSelectInnerButton >> defaultSkin [ 

	^ ToSelectInnerButtonSkin new
]

{ #category : #initialization }
ToSelectInnerButton >> initialize [

	super initialize.

	self initializeMenuItemHolder
]

{ #category : #'t - menu window model - accessing' }
ToSelectInnerButton >> menuWindow [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                widget: self;
			                yourself ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToSelectInnerButton >> popupEvent: anEvent [

	^ self menuWindow popupEvent: anEvent
]

{ #category : #'theme event handling' }
ToSelectInnerButton >> toThemeChanged [ 

	super toThemeChanged.
	self menuWindow ifNotNil: [ :mw | mw toThemeChanged ]
]
