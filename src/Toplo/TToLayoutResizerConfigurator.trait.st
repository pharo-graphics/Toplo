Trait {
	#name : #TToLayoutResizerConfigurator,
	#instVars : [
		'horizontalResizerConfigurationRequest',
		'verticalResizerConfigurationRequest'
	],
	#category : #'Toplo-Layouts-Support'
}

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> applyResizerConfigurationRequests [

	horizontalResizerConfigurationRequest ifNotNil: [ :hconf | hconf value ].
	verticalResizerConfigurationRequest ifNotNil: [ :vconf | vconf value ].
	horizontalResizerConfigurationRequest := nil.
	verticalResizerConfigurationRequest := nil
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestExact: aPoint [

	self requestHExact: aPoint x.
	self requestVExact: aPoint y
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestExactOrFitContent [

	self requestHExactOrFitContent.
	self requestVExactOrFitContent 
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestFitContent [

	self requestHFitContent.
	self requestVFitContent
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestFitContentLimited [

	self requestHFitContentLimited.
	self requestVFitContentLimited
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestFitElement: anElement [

	self requestHFitElement: anElement.
	self requestVFitElement: anElement
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestFitParent: anElement [

	self requestHFitParent: anElement.
	self requestVFitParent: anElement
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHExact: aNumber [

	horizontalResizerConfigurationRequest := [ self hExact: aNumber ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHExactOrFitContent [

	horizontalResizerConfigurationRequest := [ self hExactOrFitContent ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHFitContent [

	horizontalResizerConfigurationRequest := [ self hFitContent ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHFitContentLimited [

	horizontalResizerConfigurationRequest := [ self hFitContentLimited ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHFitElement: anElement [

	horizontalResizerConfigurationRequest := [ self hFitElement: anElement ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHFitParent: anElement [

	horizontalResizerConfigurationRequest := [ self hFitParent: anElement ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestHMatchParent [

	horizontalResizerConfigurationRequest := [ self hMatchParent ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestMatchParent [

	self requestHMatchParent.
	self requestVMatchParent
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	verticalResizerConfigurationRequest := [ self vExact: aNumber ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVExactOrFitContent [

	verticalResizerConfigurationRequest := [ self vExactOrFitContent ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVFitContent [

	verticalResizerConfigurationRequest := [ self vFitContent ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVFitContentLimited [

	verticalResizerConfigurationRequest := [ self vFitContentLimited ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVFitElement: anElement [

	verticalResizerConfigurationRequest := [ self vFitElement: anElement ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVFitParent: anElement [

	verticalResizerConfigurationRequest := [ self vFitParent: anElement ]
]

{ #category : #'t - layout resizer configurator' }
TToLayoutResizerConfigurator >> requestVMatchParent [

	verticalResizerConfigurationRequest := [ self vMatchParent ]
]
