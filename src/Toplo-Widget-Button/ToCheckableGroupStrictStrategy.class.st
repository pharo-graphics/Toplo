Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupStrictStrategy >> allowChangeWith: aCheckValue in: aGroup forCheckable: aCheckable [
	" do not allow to uncheck a button by checking it "

	(aCheckValue not and: [ aCheckable checked ]) ifTrue: [
		^ false ].
	" ok, the button is unchecked -> uncheck others then check it"
	aCheckValue ifTrue: [ aGroup uncheckAllExcept: aCheckable ].
	^ true
]

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> register: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup registeredCheckables select: [ :b |
			 b ~= aCheckable and: [ b checked ] ]) do: [ :b |
			b privateChecked: false ] ].
	super register: aCheckable in: aGroup
]
