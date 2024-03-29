Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupStrictStrategy >> allowUnchecking [

	^ false
]

{ #category : #testing }
ToCheckableGroupStrictStrategy >> checkRequestEvent: aCheckRequest in: aGroup [
	" do not allow to uncheck a button by checking it "

	(aCheckRequest checked not and: [
		 aCheckRequest currentTarget checked ]) ifTrue: [
		aCheckRequest checked: true.
		^ self ].
	" ok, the button is unchecked -> uncheck others then check it"
	aGroup uncheckAllExcept: aCheckRequest currentTarget
]

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> onButtonAdded: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b checked ] ])
			do: [ :b | b privateChecked: false ] ].
	super onButtonAdded: aCheckable in: aGroup
]
