Class {
	#name : #ToChoiceBoxMenuButton,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'menuWindow'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - menu window model - window opening/closing' }
ToChoiceBoxMenuButton >> close [

	^ self menuWindow close
]

{ #category : #'t - initialization dresser' }
ToChoiceBoxMenuButton >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToMenuWindowModelDresser next: (ToChoiceBoxMenuButtonDresser new))
]

{ #category : #initialization }
ToChoiceBoxMenuButton >> initialize [

	super initialize.

	self initializeMenuItemHolder
]

{ #category : #'t - menu window model - accessing' }
ToChoiceBoxMenuButton >> menuWindow [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                widget: self;
			                yourself ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToChoiceBoxMenuButton >> popupEvent: anEvent [

	^ self menuWindow popupEvent: anEvent
]

{ #category : #'theme event handling' }
ToChoiceBoxMenuButton >> toThemeChanged [ 

	super toThemeChanged.
	self menuWindow ifNotNil: [ :mw | mw toThemeChanged ]
]
