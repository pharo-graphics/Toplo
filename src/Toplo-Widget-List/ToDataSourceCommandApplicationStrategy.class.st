Class {
	#name : #ToDataSourceCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToDataSourceCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	element isAttachedToSceneGraph ifFalse: [
			aCommandApplier applyCommand: aCommand.
			^ self ].
	"aCommand isComposite ifTrue: ['composite ' trace. (aCommand commands do: [ :cmd | cmd trace ]). '' traceCr ]."
	element postponeAction: [ aCommandApplier applyCommand: aCommand ].
	element addedDataSourceCommand: aCommand
]
