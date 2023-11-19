Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #notifications }
ToCheckableGroupStrictStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable isChecked ifTrue: [
		(aGroup buttons select: [ :b | b ~= aCheckable and: [ b checked ] ])
			do: [ :b | b privateChecked: false ] ].
	super buttonInserted: aCheckable in: aGroup
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
