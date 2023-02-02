Trait {
	#name : #TToMenuWindowModel,
	#instVars : [
		'subMenuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
TToMenuWindowModel >> initializeMenuWindowModel [

	subMenuWindow := ToMenuWindow new.
	subMenuWindow widget: self
]

{ #category : #'t - menu window testing' }
TToMenuWindowModel >> isSubmenu [

	^ false
]

{ #category : #'t - menu window accessing' }
TToMenuWindowModel >> subMenuWindow [

	^ subMenuWindow 
]
