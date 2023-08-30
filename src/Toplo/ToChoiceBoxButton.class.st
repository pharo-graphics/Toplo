Class {
	#name : #ToChoiceBoxButton,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'menuWindow'
	],
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - menu window model - window opening/closing' }
ToChoiceBoxButton >> close [

	^ self menuWindow close
]

{ #category : #'t - initialization dresser' }
ToChoiceBoxButton >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToMenuWindowModelDresser next: (ToChoiceBoxButtonDresser next: ToTripletDresser new))
]

{ #category : #initialization }
ToChoiceBoxButton >> initialize [

	super initialize.

	self initializeMenuItemHolder
]

{ #category : #'t - menu window model - accessing' }
ToChoiceBoxButton >> menuWindow [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                widget: self;
			                yourself ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToChoiceBoxButton >> popupEvent: anEvent [

	^ self menuWindow popupEvent: anEvent
]

{ #category : #'theme event handling' }
ToChoiceBoxButton >> toThemeChanged [ 

	super toThemeChanged.
	self menuWindow ifNotNil: [ :mw | mw toThemeChanged ]
]
