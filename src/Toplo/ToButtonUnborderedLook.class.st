Class {
	#name : #ToButtonUnborderedLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Widget-Button-Look'
}

{ #category : #private }
ToButtonUnborderedLook >> borderBuilderFromElement: anElement [

	^ (super borderBuilderFromElement: anElement)
		  width: 0;
		  yourself
]

{ #category : #'event handling' }
ToButtonUnborderedLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e | e background: Color transparent ]
]
