Trait {
	#name : #TToMenuWindowModel,
	#instVars : [
		'menuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
TToMenuWindowModel >> initializeMenuWindowModel [

	menuWindow := ToMenuWindow new.
	menuWindow widget: self
]

{ #category : #'t - menu window accessing' }
TToMenuWindowModel >> menuWindow [

	^ menuWindow 
]
