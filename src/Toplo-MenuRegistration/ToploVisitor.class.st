Class {
	#name : #ToploVisitor,
	#superclass : #SMenuDeclarationVisitor,
	#category : #'Toplo-MenuRegistration-New'
}

{ #category : #initialization }
ToploVisitor >> initialize [

	menuPane := ToMenuPane new
]

{ #category : #visiting }
ToploVisitor >> visitMenuBuilder: aMenuBuilder [

	aMenuBuilder collectedItems do: [ :item |
		item isGroup ifFalse: [
			
			menuPane addItem: (item accept: self) ] ].
	^ menuPane
	
]

{ #category : #'Protocol (visiting) - 2 selector(s)' }
ToploVisitor >> visitMenuRegistration: aMenuRegistration [

	| menu |
	aMenuRegistration hasChildren
		ifTrue: [
			menu := ToMenu new labelText: aMenuRegistration curatedLabel.
			aMenuRegistration childrenItems do: [ :subItem |
				subItem isGroup 
					ifFalse: [ 
							menu addItem: (subItem accept: self).
							aMenuRegistration separator ifTrue: [ menu addSeparator ] ] ].
			 ]
		
		ifFalse: [
			menu := ToMenuItem new labelText: aMenuRegistration curatedLabel.
			menu clickAction: aMenuRegistration action.
			aMenuRegistration hasIcon ifTrue: [ menu iconImage: aMenuRegistration icon asElement ] ].
	
	^ menu
]
